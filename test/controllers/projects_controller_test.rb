require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test 'should get index' do
    get projects_url
    assert_response :success
  end

  test 'should get new' do
    get new_project_url
    assert_response :success
  end

  test 'should create project' do
    assert_difference('Project.count') do
      post projects_url, params: { project: { name: 'New Project' } }
    end

    assert_redirected_to project_url(Project.last)
    assert_equal 'Project was successfully created.', flash[:notice]
  end

  test 'should not create project with missing required fields' do
    assert_no_difference('Project.count') do
      post projects_url, params: { project: { name: '' } }
    end

    assert_response :unprocessable_entity
  end

  test 'should show project' do
    get project_url(@project)
    assert_response :success
  end

  test 'should get edit' do
    get edit_project_url(@project)
    assert_response :success
  end

  test 'should update project' do
    patch project_url(@project), params: { project: { name: 'Updated Project' } }
    assert_redirected_to project_url(@project)
    assert_equal 'Project was successfully updated.', flash[:notice]
  end

  test 'should destroy project' do
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
    assert_equal 'Project was successfully destroyed.', flash[:notice]
  end
end
