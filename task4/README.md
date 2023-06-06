This workflow builds and packages this java application using maven.

Prerequisites:
Create a self-hosted github runner with a tag local_runners

Workflow:
The first step builds the code and generates a jar file
The second step runs the tests defined in the pom file.