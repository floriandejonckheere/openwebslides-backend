# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'topics routing', :type => :routing do
  it 'routes topics endpoint' do
    route = '/api/topics'

    expect(:get => route).to route_to 'topics#index'
    expect(:patch => route).not_to be_routable
    expect(:put => route).not_to be_routable
    expect(:post => route).to route_to 'topics#create'
    expect(:delete => route).not_to be_routable
  end

  it 'routes topic endpoint' do
    route = '/api/topics/foo'

    expect(:get => route).to route_to 'topics#show', :id => 'foo'
    expect(:patch => route).to route_to 'topics#update', :id => 'foo'
    expect(:put => route).to route_to 'topics#update', :id => 'foo'
    expect(:post => route).not_to be_routable
    expect(:delete => route).to route_to 'topics#destroy', :id => 'foo'
  end

  it 'routes topic user relationship endpoint' do
    route = '/api/topics/foo/relationships/user'
    params = { :topic_id => 'foo', :relationship => 'user' }

    expect(:get => '/api/topics/foo/user').to route_to 'users#get_related_resource', params.merge(:source => 'topics')

    expect(:get => route).to route_to 'topics#show_relationship', params
    expect(:patch => route).not_to be_routable
    expect(:put => route).not_to be_routable
    expect(:post => route).not_to be_routable
    expect(:delete => route).not_to be_routable
  end

  it 'routes topic collaborators relationship endpoint' do
    route = '/api/topics/foo/relationships/collaborators'
    params = { :topic_id => 'foo', :relationship => 'collaborators' }

    expect(:get => '/api/topics/foo/collaborators').to route_to 'users#get_related_resources', params.merge(:source => 'topics')

    expect(:get => route).to route_to 'topics#show_relationship', params
    expect(:patch => route).not_to be_routable
    expect(:put => route).not_to be_routable
    expect(:post => route).not_to be_routable
    expect(:delete => route).not_to be_routable
  end

  it 'routes topic assets relationship endpoint' do
    route = '/api/topics/foo/relationships/assets'
    params = { :topic_id => 'foo', :relationship => 'assets' }

    expect(:get => '/api/topics/foo/assets').to route_to 'assets#get_related_resources', params.merge(:source => 'topics')

    expect(:get => route).to route_to 'topics#show_relationship', params
    expect(:patch => route).not_to be_routable
    expect(:put => route).not_to be_routable
    expect(:post => route).not_to be_routable
    expect(:delete => route).not_to be_routable
  end

  it 'routes topic conversations relationship endpoint' do
    route = '/api/topics/foo/relationships/conversations'
    params = { :topic_id => 'foo', :relationship => 'conversations' }

    expect(:get => '/api/topics/foo/conversations').to route_to 'conversations#get_related_resources', params.merge(:source => 'topics')

    expect(:get => route).to route_to 'topics#show_relationship', params
    expect(:patch => route).not_to be_routable
    expect(:put => route).not_to be_routable
    expect(:post => route).not_to be_routable
    expect(:delete => route).not_to be_routable
  end
end