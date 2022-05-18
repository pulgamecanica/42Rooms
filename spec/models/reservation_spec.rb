require 'rails_helper'

RSpec.describe Reservation, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "doesn't accept invalid parameters or incorrect dates" do
    c = Campus.any? ? Campus.first : Campus.create!(name: "CampusTest", country: "Mars", language: "LunaticLang", address: "Mars Street, Mars (Right next to the Earth)")
    r = Room.any? ? Room.first : Room.create!(campus: c, name: "TRoom", description: "This is a reasonable description...", capacity: 10)
    u = User.any? ?  User.first : User.create!(login: "test", email: "user@test.com")
    w = WhiteList.create!(user: u, room: r)

    it "validates ends_at > starts_at " do
      date = Time.now + 1.hour
      expect {Reservation.create!(subject: :club, starts_at: date + 10.minutes, ends_at: date, user: u, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "validates starts_at at least 10 minutes after present Time" do
      date = Time.now
      expect {Reservation.create!(subject: :club, starts_at: date, ends_at: date + 1.hour, user: u, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "validates duration is at least 10 minutes " do
      date = Time.now + 1.hour
      expect {Reservation.create!(subject: :club, starts_at: date, ends_at: date + 5.minutes, user: u, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "validates duration is 2 hours at most " do
      date = Time.now + 1.hour
      expect {Reservation.create!(subject: :club, starts_at: date, ends_at: date + 2.hours + 1.minutes, user: u, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "validates that a reservation doesn't overlap in the middle of another reservation" do
      date_start = Time.now + 1.hour
      date_end = date_start + 2.hour
      puts "    \e[34m * Creating Long reservation, from #{date_start.strftime("%H:%M")} to #{date_end.strftime("%H:%M")}\e[0m"
      Reservation.create!(subject: :club, starts_at: date_start, ends_at: date_end, user: u, room: r)
      puts "    \e[34m * Creating reservation in the middle, from #{(date_start + 30.minutes).strftime("%H:%M")} to #{(date_end - 30.minutes).strftime("%H:%M")}\e[0m"
      expect {Reservation.create!(subject: :club, starts_at: date_start + 30.minutes, ends_at: date_end - 30.minutes, user: u, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "validates that a reservation doesn't overlap in the between of another reservation" do
      date_start = Time.now + 1.hour
      date_end = date_start + 30.minutes
      puts "    \e[34m * Creating Short reservation, from #{date_start.strftime("%H:%M")} to #{date_end.strftime("%H:%M")}\e[0m"
      Reservation.create!(subject: :club, starts_at: date_start, ends_at: date_end, user: u, room: r)
      puts "    \e[34m * Creating reservation in the between, from #{(date_start - 30.minutes).strftime("%H:%M")} to #{(date_end + 30.minutes).strftime("%H:%M")}\e[0m"
      expect {Reservation.create!(subject: :club, starts_at: date_start - 30.minutes, ends_at: date_end + 30.minutes, user: u, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end
    
    it "validates that a reservation doesn't ends overlaping a reservation" do
      date_start = Time.now + 2.hour
      date_end = date_start + 30.minutes
      puts "    \e[34m * Creating reservation, from #{date_start.strftime("%H:%M")} to #{date_end.strftime("%H:%M")}\e[0m"
      Reservation.create!(subject: :club, starts_at: date_start, ends_at: date_end, user: u, room: r)
      puts "    \e[34m * Creating reservation ending inside another reservation, from #{(date_start - 1.hour).strftime("%H:%M")} to #{(date_end - 10.minutes).strftime("%H:%M")}\e[0m"
      expect {Reservation.create!(subject: :club, starts_at: date_start - 1.hour, ends_at: date_end - 10.minutes, user: u, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "validates that a reservation doesn't starts overlaping a reservation" do
      date_start = Time.now + 1.hour
      date_end = date_start + 30.minutes
      puts "    \e[34m * Creating reservation, from #{date_start.strftime("%H:%M")} to #{date_end.strftime("%H:%M")}\e[0m"
      Reservation.create!(subject: :club, starts_at: date_start, ends_at: date_end, user: u, room: r)
      puts "    \e[34m * Creating reservation starting inside another reservation, from #{(date_start + 15.minutes).strftime("%H:%M")} to #{(date_end + 10.minutes).strftime("%H:%M")}\e[0m"
      expect {Reservation.create!(subject: :club, starts_at: date_start + 15.minutes, ends_at: date_end + 10.minutes, user: u, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "validates that a user belongs to the white list" do
      test_user = User.create!(login: "another-test", email: "anotheruser@test.com")
      expect {Reservation.create!(subject: :club, starts_at: Time.now + 20.minutes, ends_at: Time.now + 50.minutes, user: test_user, room: r)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
