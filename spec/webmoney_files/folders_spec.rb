require 'spec_helper'

describe WebmoneyFiles, :webmoney do
  let(:storage) {
    WebmoneyFiles.new({
      host: 'https://files.dev.local',
      webmoney_instance: @webmoney
    })
  }

  it 'create folder' do
    response = storage.folder.create('test_folder')

    expect(response).to include('object')
    expect(response['object']).to include('id')
  end

  it 'create folder and upload file' do
    folder = storage.folder.create('test')

    file_path = File.expand_path('../../fixture/webmoney_icon.png', __FILE__)
    response = storage.file.upload(file_path, {
      parent_id: folder['object']['id']
    })

    expect(response).to include('object')
    expect(response['object']).to include('id')
    expect(response['object']['parent_id']).to eq(folder['object']['id'])
  end
end
