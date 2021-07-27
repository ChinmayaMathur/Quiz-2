require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
      describe "#new" do
            context "user signed in" do
                  before do
                        session[:user_id] = FactoryBot.create(:user).id
                  end

                  it "renders the new template" do
                        # Given 

                        # When
                        get(:new)  

                        # Then
                        expect(response).to(render_template(:new))
                  end

                  it "sets an instance variable with a idea" do
                        # Given 

                        # When
                        get(:new)

                        # Then
                        expect(assigns(:idea)).to(be_a_new(Idea))
                  end
            end

            context "with user not signed in" do
                  before do
                        session[:user_id] = nil
                  end
                  it "should redirect to the sign in page" do
                        get(:new)
                        expect(response).to redirect_to(new_sessions_path)
                  end
            end
      end

      describe "#create" do
            def valid_request 
                  post(:create, params: {idea: FactoryBot.attributes_for(:idea)})
            end
            context "with user signed in" do
                  before do 
                        session[:user_id] = FactoryBot.create(:user).id
                  end

                  context "with valid parameters" do
                        it "creates an idea in the database" do
                              # Given
                              count_before = Idea.count  # the number of all records in the JobPost table

                              # When
                              valid_request
                             
                              # Then
                              count_after = Idea.count
                              expect(count_after).to(eq(count_before + 1))       
                        end

                        it "redirects us to the index page for the new instance of idea" do
                              # Given - we are creating a new job post

                              # When
                              valid_request

                              # Then
                              expect(response).to(redirect_to request.referrer)
                        end
                  end

                  context "with invalid parameters" do
                        def invalid_request 
                              post(:create, params: {idea: FactoryBot.attributes_for(:idea, title:nil)})
                        end

                        it "does not save a record in the database" do
                              # Given
                              count_before = Idea.count  # the number of all records in the JobPost table
            
                              # When
                              invalid_request

                              # Then
                              count_after = Idea.count
                              expect(count_after).to(eq(count_before))       
                        end

                        it "renders the new template" do
                              # Given - no code

                              # When
                              invalid_request

                              # Then
                              expect(response).to render_template(:new)
                        end
                  end
            end

            context "with user not signed in" do
                  it "should redirect to the sign in page" do
                        valid_request
                        expect(response).to redirect_to(new_sessions_path)
                  end
            end
      end

end
