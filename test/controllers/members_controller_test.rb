require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = members(:one)
    @team = teams(:one)
  end

  test 'should get index' do
    get teams_url(@team)
    assert_response :success
  end

  test 'should create member' do
    assert_difference('Member.count') do
      post members_url,
           params: {
             member: {
               first_name: 'John',
               last_name: 'Doe',
               city: 'San Francisco',
               state: 'CA',
               country: 'USA',
               team_id: @team.id
             }
           }
    end

    assert_redirected_to member_url(Member.last)
    assert_equal 'Member was successfully created.', flash[:notice]
  end

  test 'should not create member with missing required fields' do
    assert_no_difference('Member.count') do
      post members_url,
           params: { member: { city: 'San Francisco', state: 'CA', country: 'USA', team_id: @team.id } }
    end

    assert_response :unprocessable_entity
  end

  test 'should show member' do
    get member_url(@member)
    assert_response :success
  end

  test 'should get edit' do
    get edit_member_url(@member)
    assert_response :success
  end

  test 'should update member' do
    patch member_url(@member),
          params: { member: { first_name: 'Updated', last_name: 'User', city: 'San Francisco', state: 'CA', country: 'USA',
                              team_id: @team.id } }
    assert_redirected_to member_url(@member)
    assert_equal 'Member was successfully updated.', flash[:notice]
  end

  test 'should not update member with missing required fields' do
    patch member_url(@member),
          params: { member: { first_name: '', last_name: '', city: 'San Francisco', state: 'CA', country: 'USA',
                              team_id: @team.id } }
    assert_response :unprocessable_entity
  end

  test 'should destroy member' do
    assert_difference('Member.count', -1) do
      delete member_url(@member)
    end

    assert_redirected_to members_url
    assert_equal 'Member was successfully destroyed.', flash[:notice]
  end

  test 'should add project to member' do
    project = projects(:one)

    assert_difference('@member.projects.count', 1) do
      post add_project_member_url(@member), params: { project_id: project.id }
    end

    assert_redirected_to member_url(@member)
    assert_equal 'Member was successfully added to the project.', flash[:notice]
  end
end
