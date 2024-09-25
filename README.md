# Flecks

Render IO-bound content asynchronously and stream it into a wrap-around shell in a single HTTP response with Phlex.

See [video demo](https://cloud.drapper.me/DYH7WFL8).

## Recommendations

Although Flecks also supports concurrent promises, threads and async ActiveRecord relations, we recommend using [async](https://github.com/socketry/async) tasks, since Fibers are much more lightweight and efficient than Threads.

We also recommend using the [Falcon](https://github.com/socketry/falcon) web server which uses multiple fibers to handle requests concurrently.

## Acknowledgements

The declarative shadow DOM technique used in this project was inspired by these two articles:
- [Out of Order Streaming using Declarative Shadow DOM](https://kevinkipp.com/blog/out-of-order-streaming-using-declarative-shadow-dom/), Kevin Kipp
- [Streaming HTML out of order without JavaScript](https://lamplightdev.com/blog/2024/01/10/streaming-html-out-of-order-without-javascript/), Chris Haynes
