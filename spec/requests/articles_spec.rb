require 'rails_helper'

# These are feature tests

RSpec.describe 'Articles API' do
  def article_params
    {
      title: 'One Weird Trick',
      content: 'You won\'t believe what happens next...'
    }
  end

  def articles
    Article.all
  end

  def article
    Article.first
  end

  before(:all) do
    Article.create!(article_params)
  end

  after(:all) do
    Article.delete_all
  end

  describe 'GET /articles' do
    it 'lists all articles' do
      get '/articles'

      expect(response).to be_success

      articles_response = JSON.parse(response.body)
      expect(articles_response.length).to eq(articles.count)
      expect(articles_response.first['title']).to eq(article[:title])
    end
  end

  describe 'GET /articles/:id' do
    it 'shows one article' do
      # double quotes for string interpolation
      get "/articles/#{article.id}"

      expect(response).to be_success

      article_response = JSON.parse(response.body)
      expect(article_response['id']).not_to be_nil
      expect(article_response['title']).to eq(article[:title])
    end
  end

  describe 'POST /articles' do
    it 'creates an article' do
      post '/articles', article: article_params, format: :json

      expect(response).to be_success

      article_response = JSON.parse(response.body)
      expect(article_response['id']).not_to be_nil
      expect(article_response['title']).to eq(article_params[:title])
    end
  end

  describe 'PATCH /articles/:id' do
    def article_diff
      { title: 'Two Stupid Tricks' }
    end

    it 'updates an article' do
      # double quotes for string interpolation
      patch "/articles/#{article.id}", article: article_diff, format: :json

      # note that this differs from previous update methods we've written
      # which don't return any content
      # this test requires content to be returned
      # or else it will fail (as written)
      expect(response).to be_success
      article_response = JSON.parse(response.body)
      expect(article_response['id']).to eq(article[:id])
      expect(article_response['title']).to eq(article_diff[:title])
    end
  end

  describe 'DELETE /articles/:id' do
    skip 'deletes an article' do
    end
  end
end
