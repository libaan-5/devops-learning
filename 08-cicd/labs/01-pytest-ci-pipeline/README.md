# 01-pytest-ci-pipeline

Goal: Build a basic CI pipeline that runs tests or checks automatically on each push.

- I created a [new repository](https://github.com/libaan-5/actions-lab) for this lab since .github/workflows would be outside of this markdown files scope.

Steps:


## 1) Configure how the pipeline would be activated, set up the testing library. 

- For testing, I used the pytest library.
- I configured the CI pipeline to run on push and on workflow_dispatch.

## 2) Create the Python code. 

- Short Python script which would print any string entered as a parameter when the function is called. 

Image of script:

<img src="images/Screenshot (19).png" alt="alt text" width="700">

## 3) Create the pytest test file.

- Pytest files must have a 'test_' prefix or a '_test' suffix.
- The same is for functions for them to be recognised.

Image of test script (test_hello.py): 

<img src="images/Screenshot (20).png" alt="alt text" width="700">

# 5) After running, I ran into an error

The error flagged by GitHub actions after pushing: 

<img src="images/Screenshot (13).png" alt="alt text" width="700">

Below, the error was simple - the docstring in the function needed another indent:

<img src="images/Screenshot (15).png" alt="alt text" width="700">

## Evidence of the pipeline running correctly:

- I tested the pipeline with 3 versions of Python (3.9, 3.10 and 3.11).
- All of them ran successfully.

<img src="images/Screenshot (17).png" alt="alt text" width="700">
 
- The test that I ran from test_hello.py ran successfully as well.

<img src="images/Screenshot (18).png" alt="alt text" width="700">

Lessons learned:

1.) Pytest files must have a 'test_' prefix or a '_test' suffix.
- The same is for functions for them to be recognised.