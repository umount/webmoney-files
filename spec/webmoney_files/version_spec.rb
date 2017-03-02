require 'spec_helper'

describe WebmoneyFiles do
  it 'has a version number' do
    expect(WebmoneyFiles::VERSION).to match(/\d+\.\d+\.\d+/)
  end
end
