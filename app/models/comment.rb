class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :development

    validates :user_id, presence: true
    validates :development_id, presence: true
    validates :body, presence: true

    def ago_in_words
        return 'a very very long time ago' if created_at.year < 1800
        secs = Time.now - created_at
        return 'just now' if secs > -1 && secs < 1
        return '' if secs <= -1
        pair = ago_in_words_pair(secs)
        ary = ago_in_words_singularize(pair)
        ary.size == 0 ? '' : ary.join(' and ') << ' ago'
    end
    
    private
    def ago_in_words_pair(secs)
        [[60, :seconds], [60, :minutes], [24, :hours], [100_000, :days]].map{ |count, name|
            if secs > 0
            secs, n = secs.divmod(count)
            "#{n.to_i} #{name}"
            end
        }.compact.reverse[0..1]
    end
    
    def ago_in_words_singularize(pair)
        if pair.size == 1
            pair.map! {|part| part[0, 2].to_i == 1 ? part.chomp('s') : part }
        else
            pair.map! {|part| part[0, 2].to_i == 1 ? part.chomp('s') : part[0, 2].to_i == 0 ? nil : part }
        end
        pair.compact
    end
end
