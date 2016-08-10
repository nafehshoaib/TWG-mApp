//
// EventDelegate.swift
//
// Copyright © 2016 Peter Zignego. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

public protocol ConnectionEventsDelegate: class {
    func clientConnected(client: Client)
    func clientDisconnected(client: Client)
    func clientConnectionFailed(client: Client, error: SlackError)
}

public protocol MessageEventsDelegate: class {
    func messageSent(client: Client, message: Message)
    func messageReceived(client: Client, message: Message)
    func messageChanged(client: Client, message: Message)
    func messageDeleted(client: Client, message: Message?)
}

public protocol ChannelEventsDelegate: class {
    func userTyping(client: Client, channel: Channel, user: User)
    func channelMarked(client: Client, channel: Channel, timestamp: String)
    func channelCreated(client: Client, channel: Channel)
    func channelDeleted(client: Client, channel: Channel)
    func channelRenamed(client: Client, channel: Channel)
    func channelArchived(client: Client, channel: Channel)
    func channelHistoryChanged(client: Client, channel: Channel)
    func channelJoined(client: Client, channel: Channel)
    func channelLeft(client: Client, channel: Channel)
}

public protocol DoNotDisturbEventsDelegate: class {
    func doNotDisturbUpdated(client: Client, dndStatus: DoNotDisturbStatus)
    func doNotDisturbUserUpdated(client: Client, dndStatus: DoNotDisturbStatus, user: User)
}

public protocol GroupEventsDelegate: class {
    func groupOpened(client: Client, group: Channel)
}

public protocol FileEventsDelegate: class {
    func fileProcessed(client: Client, file: File)
    func fileMadePrivate(client: Client, file: File)
    func fileDeleted(client: Client, file: File)
    func fileCommentAdded(client: Client, file: File, comment: Comment)
    func fileCommentEdited(client: Client, file: File, comment: Comment)
    func fileCommentDeleted(client: Client, file: File, comment: Comment)
}

public protocol PinEventsDelegate: class {
    func itemPinned(client: Client, item: Item, channel: Channel?)
    func itemUnpinned(client: Client, item: Item, channel: Channel?)
}

public protocol StarEventsDelegate: class {
    func itemStarred(client: Client, item: Item, star: Bool)
}

public protocol ReactionEventsDelegate: class {
    func reactionAdded(client: Client, reaction: String, item: Item, itemUser: String)
    func reactionRemoved(client: Client, reaction: String, item: Item, itemUser: String)
}

public protocol SlackEventsDelegate: class {
    func preferenceChanged(client: Client, preference: String, value: AnyObject?)
    func userChanged(client: Client, user: User)
    func presenceChanged(client: Client, user: User, presence: String)
    func manualPresenceChanged(client: Client, user: User, presence: String)
    func botEvent(client: Client, bot: Bot)
}

public protocol TeamEventsDelegate: class {
    func teamJoined(client: Client, user: User)
    func teamPlanChanged(client: Client, plan: String)
    func teamPreferencesChanged(client: Client, preference: String, value: AnyObject?)
    func teamNameChanged(client: Client, name: String)
    func teamDomainChanged(client: Client, domain: String)
    func teamEmailDomainChanged(client: Client, domain: String)
    func teamEmojiChanged(client: Client)
}

public protocol SubteamEventsDelegate: class {
    func subteamEvent(client: Client, userGroup: UserGroup)
    func subteamSelfAdded(client: Client, subteamID: String)
    func subteamSelfRemoved(client: Client, subteamID: String)
}

public protocol TeamProfileEventsDelegate: class {
    func teamProfileChanged(client: Client, profile: CustomProfile)
    func teamProfileDeleted(client: Client, profile: CustomProfile)
    func teamProfileReordered(client: Client, profile: CustomProfile)
}
