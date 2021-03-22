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
- Users must be logged in to create shortened URLs.
- Users do not need to be logged in to access a shortened URL.

3. **Validation**
- When passing a non-valid URL (e.g. a string that is not in correct URL format) it will error early and not store the URL.
- When passing a valid URL that is faulty (e.g. a string that is in correct URL format but does not exist), we will store the URL. The application will currently not check the existence or health of these URLs.

## Run the Application
~TODO~

## Run the Tests
~TODO~

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
- As an anonymous user, It does not allow me to pass a valid URL and return a shortened URL

**Version 3**
- As a signed in user, I can see how many times the shortened URLs have been accessed


## Further Improvements
- We currently assume that, as long as the URL formatting is correct, we can create a shortened URL. In the future we might want to consider to check the health of this endpoint before proceeding, only allowing URLs with a `2xx` response to be transformed.
- Currently the shortened URL is a random alphanumeric string with little flexibility in its format. We could give flexibility to the user by giving the ability to set the desired length of the shorthand between a min and max value.
