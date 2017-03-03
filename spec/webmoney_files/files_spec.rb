require 'spec_helper'

describe WebmoneyFiles, :webmoney do
  def storage
    @storage ||= WebmoneyFiles.new({
      host: 'https://files.dev.local',
      webmoney_instance: @webmoney
    })
  end

  it 'upload and delete file' do
    file_path = File.expand_path('../../fixture/webmoney_icon.png', __FILE__)
    file = storage.file.upload(file_path)

    expect(file).to include('object')
    expect(file['object']).to include('id')

    response = storage.file.delete(file['object']['id'])
    expect(response).to eq(true)
  end

  describe 'file exists' do
    before(:all) do
      file_path = File.expand_path('../../fixture/webmoney_icon.png', __FILE__)
      @file = storage.file.upload(file_path)['object']
    end

    after(:all) do
      storage.file.delete(@file['id'])
    end

    it 'shared file' do
      response = storage.file.shared(@file['id'])
      expect(response['object']['shared']).to eq(true)
    end
  end
end
