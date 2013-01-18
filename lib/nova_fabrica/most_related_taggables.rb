# These are useful additions to ActsAsTaggableOn
# They could be contributed to the source code. - KS

module NovaFabrica
  module MostRelatedTaggables
  
    # <tt>most_related_taggables</tt> returns an array
    # of the most similar "siblings" to this instance
    # ordered by the number of tags that they have in 
    # common with this instance.
    # 
    # Options:
    # <tt>:minimum</tt> - specify the minimum number 
    # of tags that must be in common to be considered
    # <tt>:limit</tt> - specify the maximum number of 
    # taggables to return
    # <tt>:order</tt> - specify the order clause to pass
    # to the database for ordering taggables which 
    # have the same number of tags in common
    #
    # Examples:
    # > article.most_related_taggables
    # => [#<Article id: 15>, #<Article id: 67>, #<Article id: 104>, #<Article id: 52>]
    # > article.most_related_taggables(:minimum => 3)
    # => [#<Article id: 15>, #<Article id: 67>]
    # > article.most_related_taggables(:limit => 3)
    # => [#<Article id: 15>, #<Article id: 67>, #<Article id: 104>]
    # > article.most_related_taggables(:order => 'id ASC')
    # => [#<Article id: 15>, #<Article id: 67>, #<Article id: 52>, #<Article id: 104>]
    def most_related_taggables(options={})
      min   = options[:minimum] || 0
      limit = options[:limit]   || nil
      order = options[:order]   || nil
      scopes = options[:scopes]  || []

      # Throw out any rankings below the minimum match threshold
      hash = related_taggable_rankings.reject {|k,v| k < min}

      # Turn rankings into a sorted array, highest count first
      array = hash.sort.reverse

      related_taggables = []
      array.map do |ranking|
        taggables = self.class.where(:id => ranking[1])
        scopes.each do |s|
          taggables = taggables.send(s)
        end
        if limit.to_i > 0
          taggables = taggables.limit(limit.to_i - related_taggables.size)
        end
        taggables = taggables.order(order) if order
        related_taggables = related_taggables + taggables.all
      end
      related_taggables
    end

    private
  
      # <tt>related_taggings</tt> returns an array of all 
      # Taggings (the join between the tag and the taggable 
      # item) that are related to the tags on this instance.
      def related_taggings
        ActsAsTaggableOn::Tagging.where(:tag_id => tag_ids).
                                  where("taggable_id != ?", id)
      end

      # <tt>related_taggable_tally</tt> returns a hash 
      # that counts the number of times a taggable_id 
      # shows up in related_taggings. Essentially, it is 
      # computing the similarity of the other taggables 
      # with this instance. The keys of the hash are the 
      # taggable_ids, the values are the number of times 
      # it was found.
      #
      # Example:
      # > article.related_taggable_tally
      # => {52 => 1, 67 => 3, 104 => 1, 15 => 4}
      def related_taggable_tally
        tally = {}
        related_taggings.each do |tagging|
          tally[tagging.taggable_id] ||= 0
          tally[tagging.taggable_id] += 1
        end
        tally
      end

      # <tt>related_taggable_rankings</tt> returns a hash
      # which is the inversion of related_taggable_tally.
      # It is similar to doing Hash#invert with one important 
      # difference--if two keys match, Hash#invert will 
      # overwrite one of the values, but this will put the 
      # values into an array instead.
      #
      # Example:
      # > article.related_taggable_rankings
      # => {1 => [104, 52], 3 => 67, 4 => 15}
      def related_taggable_rankings
        # Could use Hash#inverse instead
        # http://www.unixgods.org/~tilo/Ruby/invert_hash.rb
        popularity = {}
        related_taggable_tally.each_pair do |k,v|
          if popularity.has_key?(v)
            popularity[v] = [k,popularity[v]].flatten
          else
            popularity[v] = k
          end
        end
        popularity
      end

  end
end
