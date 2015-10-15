require "spec_helper"
require 'book'

describe Book do


  it "creates a book" do
    b = Book.create(name: "The Republic")
    expect(b.name).to eq "The Republic"
  end
end
