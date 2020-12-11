class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :development

    validates :user_id, presence: true
    validates :development_id, presence: true
    validates :body, presence: true

    validates_each :body do |record, attr, value|
        record.errors.add(attr, "must not contain \< or \>") if value.scan(/[<>]/).size > 0 
    end

    def ago_in_words
        return 'a very very long time ago' if created_at.year < 1800
        difference = Time.now - created_at
        return 'just now' if difference > -1 && difference < 1
        return '' if difference <= -1
        words = difference_to_words(difference)
        final = ago_in_words_singularize(words)
        final.size == 0 ? '' : final + ' ago'
    end
    
    private
    def difference_to_words(difference)
        [[60, :seconds], [60, :minutes], [24, :hours], [100_000, :days]].map{ |count, name|
            if difference > 0
                difference, n = difference.divmod(count)
                "#{n.to_i} #{name}"
            end
        }.compact.reverse[0]
    end
    
    def ago_in_words_singularize(words)
        if words.split(" ")[0] == "1"
            words.chomp("s")
        else
            words
        end
    end
end
