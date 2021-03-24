# URL Shortener

A Rails application that _"allows a user to get a short version of a URL from a long version"_.

## Problem Spec and Assumptions
The problem space has been defined as the following:

```
- Users can register
- The user must be able to create a short version of a URL
- The user must be able to navigate to the long version of the url by using the shortened version
- URLs must belong to a registered user
- Please count and display to the user how many times the URL has been used
- Please include a read.me that details how to install and run the app
```

With this, there are a few unknowns and therefore I have taken the  liberty to make the following assumptions:

1. **Storage**
- The count indicates the need for persistence of URLs.
- A URL belongs to one user, indicating a one-to-many relationship. If two users want to parse the same URL, it will be stored as two separate instances.
- For future iterations of the implementation a many-to-many relationship could be considered, but would come with drawbacks. If we want to give flexibility on how to shorten the URLs, a user no longer has control on how to do the shortening.

2. **Authentication**
- Users must be logged in to create shortened URLs and have an overview of their stored URLs.
- Users do not need to be logged in to access a shortened URL.

3. **Validation**
- When passing a non-valid URL (e.g. a string that is not in correct URL format) it will error early and not store the URL.
- When passing a valid URL that is faulty (e.g. a string that is in correct URL format but does not exist), we will store the URL. The application will currently not check the existence or health of these URLs.

## Using the Application
1. **Starting the app**.
- To start the app locally, run from the command line:
```
bin/rails server
```
This will point to `localhost:3000`.
- If you'd like to access a deployed version of the app, go to [this Heroku app](https://not-bitly-123.herokuapp.com/).

2. **Sign up / Sign in**.
- If you have no user registered, you need to first `Sign Up` (`/signup`) a user. There is a link from the home page to do so.
- If you have a user registered, you can `Log in` (`/login`) as a user. There is a link from the home page to do so.

3. **Seeing your URL instances**.

  On successful login, there is a link to `See all URLs` (or `/url_instances`).
  Here you have an overview of all your URLs, their shorthands, and how often these shorthands have been used.
  Clicking on their ID will show you specific information of that URL instance (`/url_instances/{urlInstanceId}`)

4. **Creating a new URL instance** Below the overview of URLs, you can create a new URL instance.

5. **Accessing your shorter URL** Every URL has a shorthand attached to it.
Any user can use these shortened URLs to be redirected to the original URL.
Using any of these shortened URLs works as:

6. **Using the shorthand**
If you would like to use a shorthand, this can be done by running the request:
```
GET {appHost}/short/{shorthand}
```
If the shorthand exists, it will redirect you and increase the count of the shorthand used.
If the shorthand does not exist, a `404` will be returned.

## Run the Tests
1. Run All Tests
To run the full test suite, run:
```
rspec
```

2. Run One File
If you'd rather run all tests within one file, run:
```
$ rspec <FULL_FILE_PATH>
Example:
$ rspec spec/models/url_parser_spec.rb
```

3. Run One Test
Finally you can also run one test (or group of tests) in one file by adding the line the test is in:
```
$ rspec <FULL_FILE_PATH>:<LINE_NUMBER>
Example:
$ rspec spec/models/url_parser_spec.rb:10
```

## User Stories
Over multiple iterations, I attempt to create a minimal viable product to improve over. The layout of the different product versions is as follows:

**Version 1**
- As an anonymous user, I can pass a valid URL and it will return a shortened URL.
- As an anonymous user, I can fetch the longer URL when passing a shortened URL
- As an anonymous user, I will receive an error message when I pas a string that is not in valid URL format

**Version 2**
- As an anonymous user, I can sign up to the platform
- As an anonymous user, I can sign in to the platform
- As a signed in user, I can pass a valid URL and it will return a shortened URL.
- As an anonymous user, it does not allow me to pass a valid URL and return a shortened URL
- As an anonymous user, it does allow me to use the shortened URL to access the longer URL

**Version 3**
- As a signed in user, I can see how many times the shortened URLs have been accessed


## Further Improvements
- We currently assume that, as long as the URL formatting is correct, we can create a shortened URL. In the future we might want to consider to check the health of this endpoint before proceeding, only allowing URLs with a `2xx` response to be transformed.
- Currently the shortened URL is a random alphanumeric string with little flexibility in its format. We could give flexibility to the user by giving the ability to set the desired length of the shorthand between a min and max value.
