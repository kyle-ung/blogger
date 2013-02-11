class ArticlesController < ApplicationController
	before_filter :require_login, except: [:show, :index]

	def index
	  @article = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
	end

	def new
		@article = Article.new
	end

	def create
		@author_id = params[:article].delete(:author_id)
		@article = Article.new(params[:article])
		@article.author_id = @author_id
		@article.save
		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id]).destroy
		redirect_to articles_path
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		@article.update_attributes(params[:article])

		flash.notice = "Article #{@article.title} updated!"

		redirect_to article_path(@article)
	end
end
