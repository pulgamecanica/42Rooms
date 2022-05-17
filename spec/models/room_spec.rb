require 'rails_helper'

RSpec.describe Room, type: :model do
  context "doesn't accept invalid parameters" do
    c = Campus.create!(name: "CampusTest", country: "Mars", language: "LunaticLang", address: "Mars Street, Mars (Right next to the Earth)")
    it "fails if capacity is lower than 2" do
      expect {Room.create!(campus: c, name: "TRoom", description: "This is a reasonable description...", capacity: 0)}.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "fails if name is lower than 5 and higher than 20" do
      expect {Room.create!(campus: c, name: "four", description: "This is a reasonable description...", capacity: 10)}.to raise_error(ActiveRecord::RecordInvalid)
      expect {Room.create!(campus: c, name: "This name is very big for a room", description: "This is a reasonable description...", capacity: 10)}.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "fails when type doesn't exists" do
      expect {Room.create!(campus: c, room_type: :non_existing_type, name: "TRoom", description: "This is a reasonable description...", capacity: 10)}.to raise_error(ArgumentError)
      expect {Room.create!(campus: c, room_type: -1, name: "TRoom", description: "This is a reasonable description...", capacity: 10)}.to raise_error(ArgumentError)
    end
    it "fails when status doesn't exists" do
      expect {Room.create!(campus: c, status: :non_existing_status, name: "TRoom", description: "This is a reasonable description...", capacity: 10)}.to raise_error(ArgumentError)
      expect {Room.create!(campus: c, status: -1, name: "TRoom", description: "This is a reasonable description...", capacity: 10)}.to raise_error(ArgumentError)
    end
  end
end
