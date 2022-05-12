# 42Rooms
Application for managing rooms at 42Lisboa.

## Stack
- RoR 7 🛤️
- Ruby 3 💎
- sqlite3 / PostgreSQL ℹ️
- javascript
- scss/css 🖌️
- HTML5 📄
- 42API / Google API 🔑
- Docker 🐳

***

## DB
<img width="1296" alt="Screen Shot 2022-05-11 at 23 34 02" src="https://user-images.githubusercontent.com/28810331/167958597-031e5e6e-5c4d-4478-989b-66dac202861c.png">

#### USERS 🤵
  - roles [user42, club_leader42, staff42, admin42, guest42]
  - staff is automatically added to staff Rooms whitelist
  - leader is automatically added to clubs Rooms whitelist
#### ROOMS 🚪
  - status [active, inactive, hidden]
  - type [staff_room, normal_room]
#### RESERVATIONS 🗃️
  - Subject (limited options)
  - User can make reservation if:
  - + user belongs to the room's white list
  - + user is admin
#### WHITE_LISTS 🏳️
#### CAMPUS 🏛️

***

## Rules 🚔

#### Guests Authenticate with Google *mandatory*
#### 42 Authenticate with 42Api *mandatory*
#### Only users from the campus can make reservation on the campus (admin can make anywhere)?
#### Anyone from the Internet can checkout the Reservations live but no info about them.
#### Authenticated Users can see information about Reservations live.
#### User who made reservation can update the reservation.
#### Admins can do any action that any other user can.
#### Admins manage the Room's whitelists.

***

## Layout

#### Home Page 
  - top left navbar (login: Google, 42)
  - make reservation button
  - see reservations button
  - 42 background

#### See Reservations
  - List of Reservations by campus.
  - Reservations by Room.
  - Room card with all reservations (pagination enable)

