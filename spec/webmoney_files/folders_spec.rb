require 'spec_helper'

describe WebmoneyFiles, :webmoney do
  def storage
    @storage ||= WebmoneyFiles.new({
      host: 'https://files.dev.local',
      webmoney_instance: @webmoney
    })
  end

  it 'create and delete folder' do
    folder = storage.folder.create('test_folder')

    expect(folder).to include('object')
    expect(folder['object']).to include('id')

    response = storage.folder.delete(folder['object']['id'])
    expect(response).to eq(true)
  end

  describe 'folder exists' do
    before(:all) do
      @folder = storage.folder.create('test')
    end

    after(:all) do
      storage.file.delete(@folder['id'])
    end

    it 'upload file in folder' do
      file_path = File.expand_path('../../fixture/webmoney_icon.png', __FILE__)
      file = storage.file.upload(file_path, {
        parent_id: @folder['object']['id']
      })

      expect(file).to include('object')
      expect(file['object']).to include('id')
      expect(file['object']['parent_id']).to eq(@folder['object']['id'])
    end

    it 'published folder' do
      response = storage.folder.shared(@folder['object']['id'])
      expect(response['object']['shared']).to eq(true)
    end
  end
end
