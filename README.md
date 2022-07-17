# ChatCmd

# Installation

```bash
docker run -ti -v $(pwd):/srv/app -w /srv/app elixir:1.12-alpine sh
```
```bash
mix deps.get
```
```bash
mix deps.compile
```
```bash
iex -S mix
```

# Recommendation
## run the publisher and consumer on separate terminals so you can send and view messages

# Run Publisher
## The publisher will be responsible for sending messages to the channel

```bash
iex -S mix
```

```bash
ChatCmd.Connection.Host.env() 
```

```bash
ChatCmd.Publisher.start()
```
# Run Consumer
## The consumer will be the viewer of the "chat" messages

```bash
iex -S mix
```

```bash
ChatCmd.Connection.Host.env() 
```

```bash
ChatCmd.Consumer.start()
```
