module PostsHelper
  def post_kinds_view
    ["Job Posting", "Booth Rental", "Shop for Sale"].zip(Post.kinds)
  end
  
  def post_kinds_search_view
    {"Job Postings" => Post.kinds[0], "Booth Rentals" => Post.kinds[1], "Shops for Sale" => Post.kinds[2]}
  end
  
  def post_steps_view
    ["Create", "Preview", "Post"]
  end
  
end
