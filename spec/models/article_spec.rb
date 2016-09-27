require 'rails_helper'

RSpec.describe Article do
  it 'is an article' do
    # if we create a new instance of the article class
    # it should be an Article
    # this is self-evidence but will only pass if we have an Article model
    expect(Article.new).to be_a(Article)
  end
end
