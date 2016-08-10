![SlackKit](https://cloud.githubusercontent.com/assets/8311605/10260893/5ec60f96-694e-11e5-91fd-da6845942201.png)
## SlackKit: A Swift Slack Client Library
### Description
This is a Slack client library for OS X, iOS, and tvOS written in Swift. It's intended to expose all of the functionality of Slack's [Real Time Messaging API](https://api.slack.com/rtm) as well as the [web APIs](https://api.slack.com/web) that are accessible to [bot users](https://api.slack.com/bot-users). SlackKit also supports Slack’s [OAuth 2.0](https://api.slack.com/docs/oauth) flow including the [Add to Slack](https://api.slack.com/docs/slack-button) and [Sign in with Slack](https://api.slack.com/docs/sign-in-with-slack) buttons, [incoming webhooks](https://api.slack.com/incoming-webhooks), [slash commands](https://api.slack.com/slash-commands), and [message buttons](https://api.slack.com/docs/message-buttons).

SlackKit also has alpha support for: [Swift 3](https://github.com/pvzig/SlackKit/tree/swift3), [Linux](https://github.com/pvzig/SlackKit/tree/linux)

#### Building the SlackKit Framework
To build the SlackKit project directly, first build the dependencies using Carthage or CocoaPods. To use the framework in your application, install it in one of the following ways:

### Installation
#### CocoaPods
Add the pod to your podfile:
```
pod 'SlackKit'
```
and run
```
pod install
```

#### Carthage

Add SlackKit to your Cartfile:
```
github "pvzig/SlackKit" ~> 2.0
```
and run
```
carthage bootstrap
```
**Note:** SlackKit currently takes a _long_ time for the compiler to compile with optimizations turned on. I'm currently exploring a potential fix for this issue. In the meantime, you may want to skip the waiting and build it in the debug configuration instead:
```
carthage bootstrap --configuration "Debug"
```
Drag the built `SlackKit.framework` into your Xcode project.

#### Swift Package Manager
Add SlackKit to your Package.swift
```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/pvzig/SlackKit.git", majorVersion: 2)
    ]
)
```
Run `swift build` on your application’s main directory.

To use the library in your project import it:
```
import SlackKit
```

### Usage

#### OAuth
Slack has [many different oauth scopes](https://api.slack.com/docs/oauth-scopes) that can be combined in different ways. If your application does not request the proper OAuth scopes, your API calls will fail. 

If you authenticate using OAuth and the Add to Slack or Sign in with Slack buttons this is handled for you.

If you wish to make OAuth requests yourself, you can generate them using the `authorizeRequest` function on `SlackKit`’s `oauth` property:
```swift
func authorizeRequest(scope:[Scope], redirectURI: String, state: String = "slackkit", team: String? = nil)
```

For local development of things like OAuth, slash commands, and message buttons that require connecting over `https`, you may want to use a tool like [ngrok](https://ngrok.com) or [localtunnel](http://localtunnel.me).

#### Incoming Webhooks
After [configuring your incoming webhook in Slack](https://my.slack.com/services/new/incoming-webhook/), initialize IncomingWebhook with the provided URL and use `postMessage` to send messages.
```swift
let incoming = IncomingWebhook(url: "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX")
let message = Response(text: "Hello, World!")
incoming.postMessage(message)
```

#### Slash Commands
After [configuring your slash command in Slack](https://my.slack.com/services/new/slash-commands) (you can also provide slash commands as part of a [Slack App](https://api.slack.com/slack-apps)), initialize a webhook server with the token for the slash command, a configured route, and a response.
```swift
let response = Response(text: "Hello, World!", responseType: .InChannel)
let webhook = WebhookServer(token: "SLASH-COMMAND-TOKEN", route: "hello_world", response: response)
webhook.start()
```
When a user enters that slash command, it will hit your configured route and return the response you specified.

To add additional routes and responses, you can use WebhookServer’s addRoute function:
```swift 
func addRoute(route: String, response: Response)
```

#### Message Buttons
If you are developing a Slack App and are authorizing using OAuth, you can use [message buttons](https://api.slack.com/docs/message-buttons).

To send messages with actions, add them to an attachment:
```swift
let helloAction = Action(name: "hello_world", text: "Hello, World!")
let attachment = Attachment(fallback: "Hello World Attachment", title: "Attachment with an Action Button", callbackID: "helloworld", actions: [helloAction])
```

To act on message actions, initialize an instance of the `MessageActionServer` using your app’s verification token, your specified interactive messages request URL route, and a `MessageActionResponder`:
```swift
let action = Action(name: "hello_world", text: "Hello, World!")
let response = Response(text: "Hello, 🌎!", responseType: .InChannel)
let responder = MessageActionResponder(responses: [(action, response)])
let server = MessageActionServer(token: "SLACK-APP-VERIFICATION-TOKEN", route: "actions", responder: responder)
server.start()
```

#### Bot Users
To deploy a bot user using SlackKit you'll need a bearer token which identifies a single user. You can generate a [full access token or create one using OAuth 2](https://api.slack.com/web).

Initialize a SlackKit instance using your [application’s Client ID and Client Secret](https://api.slack.com/apps) to set up SlackKit for OAuth authorization:
```swift
let bot = SlackKit(clientID: "CLIENT_ID", clientSecret: "CLIENT_SECRET")
```

or use a manually acquired token:
```swift
let bot = SlackKit(withAPIToken: "xoxp-YOUR-SLACK-API-TOKEN")
```

#### Client Connection Options
You can also set options for a ping/pong interval, timeout interval, and automatic reconnection:
```swift
let options = ClientOptions(pingInterval: 2, timeout: 10, reconnect: false)
let bot = SlackKit(clientID: "CLIENT_ID", clientSecret: "CLIENT_SECRET", clientOptions: options)
```

Once connected, the client will begin to consume any messages sent by the Slack RTM API.

#### Web API Methods
SlackKit currently supports the a subset of the Slack Web APIs that are available to bot users:

- api.test
- auth.revoke
- auth.test
- channels.history
- channels.info
- channels.list
- channels.mark
- channels.setPurpose
- channels.setTopic
- chat.delete
- chat.postMessage
- chat.update
- emoji.list
- files.comments.add
- files.comments.edit
- files.comments.delete
- files.delete
- files.info
- files.upload
- groups.close
- groups.history
- groups.info
- groups.list
- groups.mark
- groups.open
- groups.setPurpose
- groups.setTopic
- im.close
- im.history
- im.list
- im.mark
- im.open
- mpim.close
- mpim.history
- mpim.list
- mpim.mark
- mpim.open
- oauth.access
- pins.add
- pins.list
- pins.remove
- reactions.add
- reactions.get
- reactions.list
- reactions.remove
- rtm.start
- stars.add
- stars.remove
- team.info
- users.getPresence
- users.info
- users.list
- users.setActive
- users.setPresence

They can be accessed through a Client object’s `webAPI` property:
```swift
client.webAPI.authenticationTest({ (authenticated) -> Void in
	print(authenticated)
}){(error) -> Void in
	print(error)
}
```

#### Delegate methods

To receive delegate callbacks for events, register an object as the delegate for those events using the `onClientInitalization` block:
```swift
let bot = SlackKit(clientID: "CLIENT_ID", clientSecret: "CLIENT_SECRET")
bot.onClientInitalization = { (client: Client) in
    dispatch_async(dispatch_get_main_queue(), {
		client.connectionEventsDelegate = self
	    client.messageEventsDelegate = self
	})
}
```

Delegate callbacks contain a reference to the Client where the event occurred.

There are a number of delegates that you can set to receive callbacks for certain events.

##### ConnectionEventsDelegate
```swift
clientConnected(client: Client)
clientDisconnected(client: Client)
clientConnectionFailed(client: Client, error: SlackError)
```
##### MessageEventsDelegate
```swift
messageSent(client: Client, message: Message)
messageReceived(client: Client, message: Message)
messageChanged(client: Client, message: Message)
messageDeleted(client: Client, message: Message?)
```
##### ChannelEventsDelegate
```swift
userTyping(client: Client, channel: Channel, user: User)
channelMarked(client: Client, channel: Channel, timestamp: String)
channelCreated(client: Client, channel: Channel)
channelDeleted(client: Client, channel: Channel)
channelRenamed(client: Client, channel: Channel)
channelArchived(client: Client, channel: Channel)
channelHistoryChanged(client: Client, channel: Channel)
channelJoined(client: Client, channel: Channel)
channelLeft(client: Client, channel: Channel)
```
##### DoNotDisturbEventsDelegate
```swift
doNotDisturbUpdated(client: Client, dndStatus: DoNotDisturbStatus)
doNotDisturbUserUpdated(client: Client, dndStatus: DoNotDisturbStatus, user: User)
```
##### GroupEventsDelegate
```swift
groupOpened(client: Client, group: Channel)
```
##### FileEventsDelegate
```swift
fileProcessed(client: Client, file: File)
fileMadePrivate(client: Client, file: File)
fileDeleted(client: Client, file: File)
fileCommentAdded(client: Client, file: File, comment: Comment)
fileCommentEdited(client: Client, file: File, comment: Comment)
fileCommentDeleted(client: Client, file: File, comment: Comment)
```
##### PinEventsDelegate
```swift
itemPinned(client: Client, item: Item, channel: Channel?)
itemUnpinned(client: Client, item: Item, channel: Channel?)
```
##### StarEventsDelegate
```swift
itemStarred(client: Client, item: Item, star: Bool)
```
##### ReactionEventsDelegate
```swift
reactionAdded(client: Client, reaction: String, item: Item, itemUser: String)
reactionRemoved(client: Client, reaction: String, item: Item, itemUser: String)
```
##### SlackEventsDelegate
```swift
preferenceChanged(client: Client, preference: String, value: AnyObject?)
userChanged(client: Client, user: User)
presenceChanged(client: Client, user: User, presence: String)
manualPresenceChanged(client: Client, user: User, presence: String)
botEvent(client: Client, bot: Bot)
```
##### TeamEventsDelegate
```swift
teamJoined(client: Client, user: User)
teamPlanChanged(client: Client, plan: String)
teamPreferencesChanged(client: Client, preference: String, value: AnyObject?)
teamNameChanged(client: Client, name: String)
teamDomainChanged(client: Client, domain: String)
teamEmailDomainChanged(client: Client, domain: String)
teamEmojiChanged(client: Client)
```
##### SubteamEventsDelegate
```swift
subteamEvent(client: Client, userGroup: UserGroup)
subteamSelfAdded(client: Client, subteamID: String)
subteamSelfRemoved(client: Client, subteamID: String)
```
##### TeamProfileEventsDelegate
```swift
teamProfileChanged(client: Client, profile: CustomProfile)
teamProfileDeleted(client: Client, profile: CustomProfile)
teamProfileReordered(client: Client, profile: CustomProfile)
```

### Examples
[Check out example applications here.](https://github.com/pvzig/SlackKit-examples)

### Get In Touch
[@pvzig](https://twitter.com/pvzig)

<peter@launchsoft.co>
