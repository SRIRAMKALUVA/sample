module Marticle
  extend ActiveSupport::Concern
  def post_article
    @user = User.find(session[:user_id])
    #has_one
    article = Article.new({title: params[:title], content:params[:content], user: @user})
    #has_many
    # article = @user.articles.new({title: params[:title], content:params[:content]})

    if article.save
      flash[:notice] = "Article saved successfully"
      redirect_to users_path
    else
      flash[:notice] = "Something went wrong"
      render :create_article
    end
  end
end
