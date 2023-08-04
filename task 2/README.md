# Assigment Two
## Description
In this directory you can find code for a simple Go app, that serves multiple HTTP endpoints.

Task is to create a script called `script.sh`, that will build and run this app in Docker container. You should be able to send request to this app outside of container. Script should also stop container on exit.

## How to build and run this code
* To build app and create executable called `app` execute in this directory
    ```
    $ go build -o app
    ```
* To run app:
    ```
    $ ./app
    ```
    ```
    2023/07/25 14:34:57 App started. Will listen on :8080
    ```
* To run app on different port (e.g. 12345) execute:
    ```
    $ BIND_ADDRESS=:12345 ./app
    ```
    ```
    2023/07/25 14:35:09 App started. Will listen on :12345
    ```

### Bonus points
* Add to script option called "--port", that allows specifying different port.
* Add to script option called "--healthcheck", that will check, if container is running.
* There is no shell in built image