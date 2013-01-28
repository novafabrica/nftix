#  shared examples for CRUD
#  specs for standard controller actions
#  uses:
#    inner_params: params to add to the 'inner' hash
#              (could likely be refactored out to just use outer_params since the merge can merge with inner)
#    outer_params: params to add to the outside (used for scoping)
#    singular_as_model_name: if defined, uses singular as the params key (such as when admins and members share a model)
#    item: object under test, instance object of class, such as a member.
#    touch_params: how this object should be 'touched' to note it has changed; also how
#                  invalid posts are created automagically, by setting the hash value to nil.
#    create_redirect_path, update_redirect_path: where it should redirect to. leave blank to simply check that a redirect occured
#    scope: to ensure a controller find is scoped to an object
#
#  example of block setting all variables
#   let(:params) {{}}
#   let(:item) { @category }
#   let(:singular) {'single_item'}
#   let(:create_redirect_path) { staff_categories_path }
#   let(:update_redirect_path) { staff_categories_path }
#   let(:touch_params) {{:name => 'billy'}}
#   let(:scope) {@tutorial.categories}
#   let(:sub_model) { true }


shared_examples "a standard index action" do

  it "should assign found items to an instance variable" do
   get :index, outer_params
   assigns[singular.pluralize.to_sym].should == [item]
  end

  it "should render the listing index" do
    get :index, outer_params
    response.should render_template("index")
  end
end

shared_examples "a standard show action" do

  it "should assign found item to an instance variable" do
    get :show, { :id => item.id }.merge(outer_params)
    assigns[singular.to_sym].should == item
  end

  it "should be a success" do
    get :show, { :id => item.id }.merge(outer_params)
    response.should be_success
  end

  it "should render the show template" do
    get :show, { :id => item.id }.merge(outer_params)
    response.should render_template(:show)
  end
end

shared_examples "a standard new action" do

    it "should be a success" do
      get :new, outer_params
      response.should be_success
    end

    it "should create a new instance and assign it to an instance variable" do
      newitem = item.class.new
      item.class.stub!(:new).and_return(newitem)
      get :new, outer_params
      assigns[singular.to_sym].should == newitem
    end

    it "should render the new template" do
      get :new, outer_params
      response.should render_template(:new)
  end
end


shared_examples "a standard create action" do

    context "successful" do

      it "should create a new item" do
        lambda do
          post_create
        end.should change(item.class, :count).by(1)
      end

      it "should flash a notice" do
        post_create
        flash[:notice].should_not be_nil
      end

      it "should redirect" do
        post_create
        if create_redirect_path.nil?
          response.should be_redirect
        else
          response.should redirect_to(create_redirect_path)
        end
      end
    end

    context "unsuccessful" do

      it "should render the new template " do
        item.class.any_instance.should_receive(:save).and_return(false)
        post_create
        response.should render_template(:new)
      end
    end
    def post_create(options = {} )

      param_key = defined?(singular_as_model_name) ? singular.to_sym : item.class.to_s.underscore.downcase.to_sym
      attributes = FactoryGirl.attributes_for(param_key).with_indifferent_access
      post :create, { param_key => attributes.merge(inner_params).merge(options) }.merge(outer_params)
    end

end

# TODO: remove the need for this; some controllers are harder to make fail in specs, but all should be able to.
shared_examples "a standard create action that has no unsuccessful scenario" do

    it "should create a new item" do
      lambda do
        post_create
      end.should change(item.class, :count).by(1)
    end

    it "should flash a notice" do
      post_create
      flash[:notice].should_not be_nil
    end

    it "should redirect" do
      post_create
      if create_redirect_path.nil?
        response.should be_redirect
      else
        response.should redirect_to(create_redirect_path || item.class.last)
      end
    end

    def post_create(options = {})
      param_key = defined?(singular_as_model_name) ? singular.to_sym : item.class.to_s.underscore.downcase.to_sym
      post :create, {
        param_key => FactoryGirl.attributes_for(param_key).merge(inner_params).merge(options)
      }.merge(outer_params)
    end
end

shared_examples "a standard edit action" do

    it "should assign found item to an instance variable" do
      get_edit
      assigns[singular.to_sym].should == item
    end

    it "should be a success" do
      get_edit
      response.should be_success
    end

    it "should render the edit template" do
      get_edit
      response.should render_template("edit")
    end

    def get_edit
      get :edit, { :id => item.id }.merge(outer_params)
    end
end

shared_examples "a standard update action" do

    context "successful" do

      it "should update the item attributes" do
        updated = item.updated_at
        put_update(touch_params)
        item.reload.updated_at.should_not == updated
      end

      it "should flash a notice" do
        put_update(touch_params)
        flash[:notice].should_not be_empty
      end

      it "should redirect" do
        put_update(touch_params)
        if update_redirect_path.nil?
          response.should be_redirect
        else
          response.should redirect_to(update_redirect_path)
        end
      end

    end

    context "unsuccessful" do

      it "should render the edit template" do
        item.class.any_instance.stub(:update).and_return(false)
        put_update(touch_params)
        response.should render_template(:edit)
      end

    end

    def put_update(options = {})
      param_key = defined?(singular_as_model_name) ? singular.to_sym : item.class.to_s.underscore.downcase.to_sym
      put :update, {:id => item.id, param_key => inner_params.merge(options)}.merge(outer_params)
    end
end

# TODO: remove the need for this; some controllers are harder to make fail in specs, but all should be able.
shared_examples "a standard update action that has no unsuccessful scenario" do

    it "should update the item attributes" do
      updated = item.updated_at
      put_update(touch_params)
      item.reload.updated_at.should_not == updated
    end

    it "should flash a notice" do
      put_update
      flash[:notice].should_not be_nil
    end

    it "should redirect" do
      put_update(touch_params)
      if create_redirect_path.nil?
        response.should be_redirect
      else
        response.should redirect_to(update_redirect_path)
      end
    end

    def put_update(options = {})
      param_key = defined?(singular_as_model_name) ? singular.to_sym : item.class.to_s.underscore.downcase.to_sym
      put :update, {:id => item.id, param_key => inner_params.merge(options)}.merge(outer_params)
    end
end

shared_examples "a standard delete action" do

    it "should assign found item to an instance variable" do
      get_delete
      assigns[singular.to_sym].should == item
    end

    it "should be a success" do
      get_delete
      response.should be_success
    end

    it "should render the delete template" do
      get_delete
      response.should render_template("delete")
    end

    def get_delete
      get :delete, {:id => item.id}.merge(outer_params)
    end
end

shared_examples "a standard destroy action" do

    it "should delete the item" do
      lambda do
        delete_destroy
      end.should change(item.class, :count).by(-1)
    end

    it "should flash a notice" do
      delete_destroy
      flash[:notice].should_not be_nil
    end

    def delete_destroy
      delete :destroy, {:id => item.id}.merge(outer_params)
    end

end