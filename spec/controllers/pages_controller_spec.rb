require 'rails_helper'

RSpec.describe PagesController do
  render_views

  describe 'GET show' do
    context 'page exists' do
      context 'active' do
        subject { create(:page, active: true) }
        it 'renders the page' do
          get :show, slug: subject.slug
          expect(response).to be_successful
          expect(response).to render_template :show
          expect(response.body).to include(subject.body)
        end
      end

      context 'inactive' do
        subject { create(:page, active: false) }
        it 'renders 404' do
          get :show, slug: subject.slug
          expect(response).to be_not_found
          expect(response).to render_template 'errors/404'
        end
      end


    end

    context 'page does not exist' do
      it 'renders 404' do
        get :show, slug: 'no_page'
        expect(response).to be_not_found
        expect(response).to render_template 'errors/404'
      end
    end
  end
end