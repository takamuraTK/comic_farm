module UsersHelper
  def get_color(comic)
    publisher = Bookseries.find_by(title: comic).publisher
    color = case publisher
            when '集英社'
              'btn-primary'
            when '小学館'
              'btn-outline-dark'
            when '講談社'
              'btn-success'
            when '竹書房'
              'btn-danger'
            when '新潮社'
              'btn-warning'
            when '双葉社'
              'btn-light'
            when '秋田書店'
              'btn-secondary'
            when '少年画報社'
              'btn-info'
            else
              'btn-dark'
            end
    color
  end
end