module StoresHelper

  include ApplicationHelper

    def has_store(store)
        current_user.store == store && current_user.store
    end

    def category
        %w(食品 スポーツ ファッション デジタル ＩＴ 生活)
    end
end
