require "spec_helper"
require 'book'
require "support/helpers/cleaner"

describe Book do


  it "creates a book" do
    b = Book.create(name: "The Republic")
    expect(b.name).to eq "The Republic"
    remove_objects(Book)
  end
end
