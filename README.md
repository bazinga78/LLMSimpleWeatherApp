LLMSimpleWeatherApp
===================

LLMSimpleWeatherApp is a very simple application to show to the user the current weather in London. It uses the API from http://openweathermap.org/ to retrieve data about weather.

Architecture
-------------
During this exercise I tried to focus more on the app architecture than just add a lot feature. The architecture I used in this project is a revised version of what I always tried to use in all my projects. I'm a big fan of Bob "Uncle" Martin, I read his book "Clean code" a few times. One day I read a post from him about his thoughts on MVC and on how this pattern fails to achive its own goals. Then he introduce a very neat architecture, called "Clean Architecture", and I've just fallen in love with it (http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html).

Project components
-------------------

#### Entities

They are the building block of the business logic's core. Usually they describe the domain and are simple plain object without any logic.

#### Interactor & Managers

An Interactor is essentially the implementation of a feature (or use case). The interactor uses Entities and Manager to perform its task.
A Manager is an object which is responsible to gather information from external sources (like a database or a webservice) hiding the details to the interactor.
An interactor doesn't know how to present the data to the user, its only responsibility is to perform the task (it's role) coordinating the interactions between managers and applying business rules to the data it manipulates.

#### Presenter

The role of the presenter is to ask to the interactors to perform their duties and use the results to instruct views to show these results. The presenter never works with data from the business logic or never applies business rules to this data.

#### View

Their role is to present data to the user. They are very stupid, they have just to perform all visual things.

About the project
------

As I said before I tried to focus on the architecture. I tried to use less external libraries as possible, not because I don't like to but just because I didn't feel it was right thing to do in this kind of exercise. 
I tried to write unit test for all of the components, but some are missing for the 'view' component of the app. I like my test code to be clear as possible because I feel it as the same importance as the 'actual' code. So I usually try to use helper method to have to code as much readable as possible.
I spent a few time on the UI components because I like my app to be visually pleasant. As you can see, I didn't spent on it too much time since I thought it wasn't the goal of this exercise.
