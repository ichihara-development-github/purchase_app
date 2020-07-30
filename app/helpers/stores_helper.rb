module StoresHelper

  include ApplicationHelper

    def has_store(store)
      if current_user.store
        current_user.store == store
      end
    end

    def category
        category = %w(食品 スポーツ ファッション デジタル ＩＴ 生活)
    end
end
