require 'rails_helper'

RSpec.describe SkillsetsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/skillsets').to route_to('skillsets#index')
    end

    it 'routes to #create' do
      expect(post: '/skillsets').to route_to('skillsets#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/skillsets').to route_to('skillsets#destroy')
    end
  end
end
