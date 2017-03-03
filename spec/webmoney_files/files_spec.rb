require 'spec_helper'

describe WebmoneyFiles, :webmoney do
  let(:storage) {
    WebmoneyFiles.new({
      host: 'https://files.dev.local',
      webmoney_instance: @webmoney
    })
  }

  it 'upload file by path' do
    file_path = File.expand_path('../../fixture/webmoney_icon.png', __FILE__)
    response = storage.file.upload(file_path)

    expect(response).to include('object')
    expect(response['object']).to include('id')
  end
end
