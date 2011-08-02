module PostsHelper
  def post_kinds_view
    ["Job Posting", "Booth Rental", "Shop for Sale"].zip(Post.kinds)
  end
  
  def post_kinds_search_view
    {t(:job_posting_option) => Post.kinds[0], t(:both_rental_option) => Post.kinds[1], t(:shop_sale_option) => Post.kinds[2]}
  end
  
  def post_steps_view
    ["Create", "Preview", "Post"]
  end
  
end
