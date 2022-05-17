# :door: 42Rooms  
Application for managing rooms at 42Lisboa.

## Stack :computer: 
- RoR 7 🛤️
- Ruby 3 💎
- Sqlite3 / PostgreSQL ℹ️
- JavaScript
- SASS(SCSS)/CSS 🖌️
- HTML5 📄
- 42API / Google API 🔑
- Docker 🐳
- JQuery
- [RSpec](https://rubydoc.info/gems/rspec-rails)

***

## DB :information_source: 
<img width="1296" alt="Screen Shot 2022-05-11 at 23 34 02" src="https://user-images.githubusercontent.com/28810331/167958597-031e5e6e-5c4d-4478-989b-66dac202861c.png">

#### USERS 🤵
  - roles [user42, staff42, admin42, guest42]
  - staff is automatically added to staff Rooms whitelist.
  - when a user is created it is added to all the whitelists where it belongs.
  - admin users manage the black/white lists.
#### ROOMS 🚪
  - status [active, inactive, hidden]
  - type [staff_room, normal_room]
  - after a room is created it adds all the users that belong to it's whitelist.
#### RESERVATIONS 🗃️
  - Subject (limited options).
  - User can make reservation if:
  - + user belongs to the room's white list.
  - + user is admin.
#### WHITE_LISTS :white_large_square:
  - Room whitelist allows users to book meetings
#### CAMPUS 🏛️
  - All campus are loaded with a seed using the API.

***

## Rules 🚔

#### Guests is on Hold for now...
#### 42 Authenticate with 42Api *mandatory*
#### Normal Users can only make reservations on their campus.
#### Staff can make reservation anywhere
#### Anyone from the Internet can checkout the Reservations live but no info about them.
#### Authenticated Users can see information about Reservations live.
#### User who made reservation can update the reservation once and only 15 before it starts.
#### A user can only have 3 active reservations at a time.
#### Admins can do any action that any other user can.
#### Admins manage the Room's whitelists.
#### User is added to white lists on creation.
#### When a room is created the white list is created.

***

## List :page_with_curl: 
- [x] Create my first HackMD note (this one!)

## Validations :thumbsup:
- [X] User email is valid.
- [X] Room name is between 5-20 characters.
- [X] Room type is mandatory.
- [X] Room description is between 5-100 characters.
- [X] Room capacity is positive number.
- [ ] Reservation starts at least 10 minutes after Present time.
- [ ] Reservation ends at most 2 hours after it starts.
- [ ] Reservation doesn't overlaps another reservation.
- [ ] (Reservation) User belongs to the reservation white list.
- [ ] (Reservation) Room is active in order to reservate.
- [ ] Black list User and Black list Room unique.
- [ ] White list User and Black list Room unique.
- [ ] Room reservations (for autenticated users and not autenticated) model scope function.
- [ ] Room reservations scope for active only.
- [ ] Reservation to_s for authenticated users and not autenticated users.
- [ ] User can have at most 3 reservations every time.
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

