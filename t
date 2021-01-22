
[1mFrom:[0m /mnt/d/programming/Rails/PraxisPost/app/controllers/posts_controller.rb:39 PostsController#show:

    [1;34m32[0m: [32mdef[0m [1;34mshow[0m
    [1;34m33[0m:     [32mif[0m !logged_in?
    [1;34m34[0m:         redirect_to signin_path, [33m:error[0m => [31m[1;31m"[0m[31mPlease login to view comments[1;31m"[0m[31m[0m
    [1;34m35[0m:     [32mend[0m  
    [1;34m36[0m:     @user = [1;34;4mUser[0m.find_by([35mid[0m: session[[33m:user_id[0m])
    [1;34m37[0m:     @comments = @post.comments.all
    [1;34m38[0m:     @comment = @post.comments.new
 => [1;34m39[0m:     binding.pry
    [1;34m40[0m: [32mend[0m

