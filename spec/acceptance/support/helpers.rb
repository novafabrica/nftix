module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.
  def should_have_errors(*messages)
    within(:css, "#errorExplanation") do
      messages.each { |msg| page.should have_content(msg) }
    end
  end

  alias_method :should_have_error, :should_have_errors

  def fill_the_following(fields)
    fields.each do |field, value|
      fill_in field, :with => value
    end
  end

  def should_have_the_following(*contents)
    contents.each do |content|
      page.should have_content(content)
    end
  end

  def should_have_table(table_name, *rows)
    within(table_name) do
      rows.each do |columns|
        columns.each { |content| page.should have_content(content) }
      end
    end
  end

  def create_interests
  %w(painting knitting sewing jewelry paper printmaking).each_with_index do |subject, i|
     Subject.create(:name => subject, :visible => true, :position => i+1)
   end
  end

  def rand_in_range(from, to)
    rand * (to - from) + from
  end

end

RSpec.configure do |config|
  config.include HelperMethods, :type => :acceptance
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
end
