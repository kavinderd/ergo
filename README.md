# Ergo (Under Construction)
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/kavinderd/ergo?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Ergo is a micro-service similar to IFTT or Huginn but with much more limited abilities. Ergo is intended to be used to send digest emails, tweets, or similar alert notifications. Ergo does not connect to any external service, but can be sent JSON payloads through it's api (ergo-api).  Ergo has been created as just a practice app for myself, but I intend to use it for various digest emails to avoid having to manually check sites.

## Description

The idea behind Ergo came from my desire to work on something like IFTT in conjunction with a desire to avoid having to maintain numerous connection to various services (Twitter, Email, News sources etc). I think any monolithic approach to this kind of an app will lead to trying to be everything to everyone and the lines of code will only increase with every new connection to every new service. Ergo takes a different approach, and one that I think will be more maintainable in the long run. 

Ergo provides a simple Rails backend where users can create Triggers that monitor events and send responses based on frequency and event count.  Ergo then accepts events via its API and sends Response to Clients via HTTP POST calls.  In comparison to IFTT, Ergo is the place where you create Triggers(Recipes) based on event names. Where those events come from and how those responses are sent to end users are outside the scope of Ergo. This means you can have numerous micro-apps that send events to numerous ergo-apps that then send responses to numerous client apps.  For instance, if I'm monitoring some event ("New Low Price") on my little web app from API X and you're already doing the same from API Y then we can easily aggregate our data by sending it with the same event name ("New Low Price") to a single ergo app and can both subscribe as Clients to a Trigger, or set different Triggers or whatever else. Events, Triggers, and Responses are modular components that are meant to be decentralized and independently scalable.

It's not all roses for Ergo. The downside of this modularity is that Ergo requires more setup. Deploying the app itself does not give you much on its own, you need to have something sending Ergo events and something that can receive Ergo responses. So if you need something ready to go use Huginn or IFTT. If you want to have more control, try out Ergo.

## Usage

To use ergo application:

- clone this repo
- bundle install
- rails s

To deploy go about deploying with your preferred method. Ergo should work on all deployment enviornments with vanilla configuration.

## Documentation

More thorough documentation can be found at the (Wiki)[https://github.com/kavinderd/ergo/wiki] for this repo.

## Example
**Congress Vote Alert**
Any day congress votes on a bill, send me an email with the vote and the outcome.

This example would work in the following ways. I have a small app deployed in the cloud that checks a government API once a day specifically requesting information on that days votes.  That small web app sends the information formatted as an Ergo::Event:

```ruby```
post "/api/v1/events", token: "USER TOKEN", event { name: "Congressional Votes", count: 1, data: { text: "Today there were ..." } 
```

If there is an Ergo::Trigger that is set to send a response when it receives "Congressional Votes" on a daily basis, then this event will trigger an HTTP response to one or more Ergo::Clients

## Contribution

If you've made it this far perhaps you should consider contributing to Ergo. Join me on [Gitter](https://gitter.im/kavinderd/ergo) to chat about development. Check out the [Trello Board](https://trello.com/b/Doz0IKZD/ergo-app). 

