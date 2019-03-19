## ECE 571 Final Project -- Verify a CPU (MIPS16) with a 5-stage pipeline using the verification techniques and constructs (ex: program blocks, clocking blocks,minterfaces, assertions, etc.)
## <b>This assignment is worth 100 points.  Final project presentations will be conducted on Mon, 18-Mar and Tue, 19-Mar.  Time/Place will be posted to D2L. Deliverables are due on Wed, 20-Mar by 10:00 PM. NO LATE SUBMISSIONS, PLEASE </b>

### <i> We will be using GitHub classroom for this assignment.  You should submit your assignment before the deadline by pushing your final code and other deliverables to your team's  GitHub repository for the assignment.</i>

## After completing this assignment students should have:
- Gained experience w/ unit level and core level design verification
- Gained experience w/ hardware emulation using the Mentor Graphics Veloce emulation system
- Gained experience w/ SystemVerilog verification techniques using checkers, assertions, randomization, etc
- Gained experience making a technical presentation

### Final Project write-up:

[Final Project Assignment](./docs/ece_571_final_project_draft.pdf)

### Summary

The final project is a chance to put what you learned this term into practice.  Each team will perform unit-level and full-core testing on the same design - a working simplified MIPS core that implements the "classic" MIPS 5-stage pipeline. Doing a thorough unit-level verification for each of the functional blocks in the design will require the creation of test programs written in MIPS16 assembly language and suitable assertions to check for the proper operation of the hardware.  Verification should also be done on the full CPU core and pipeline, perhaps using Constrained Randomization, additional assertions, checkers and scoreboards.  Once verification has been completed on the working MIPS16 core the team will repeat their verification on a core with defects, the goal being to identify the defect(s) and suggest potential fixes.

The final project also includes verification using hardware emulation.  PSU is one of a very small number of universities that have been given a Veloce emulation system by Mentor Graphics are we are fortunate to be able to use it for this course.  Due to time limitations for the project, we expect teams to perform their verification using Velcoe Standalone mode.

The final project will culminate in a technical presentation being made to the instructor, T/A and Grader for the course.  The teams should present their verification environment, verification strategy, verification approach, test results, and lessons learned during this presentation.  Each team will have 15-20 minutes to make their presentation.  

We will be using the Group Project support in GitHub classroom for this assignment.  This means that your team will share a private repository on GitHub that can also be accessed by the instructor, T/A and Grader for the course. You will submit your work via that repository.  We will review your work and provide feedback based on what your final submission was.  The process for accepting this assignment will be described in an D2L announcement.  The process is not much different than that of creating a new team in D2L. One of the team members should create a new group in GitHub classroom, accept the assignment,  and tell his/her partners what group to join.  The other members than join the group and accept the assignment.   Please join only your team;  joining another team either accidentally or deliberately could prevent the actual team member(s) for that group to join.

### Where to submit your deliverables for the project:
- Draft Verification Plan:  Submit to your Final Project Draft Verification Plan dropbox on D2L.  Include a .pdf of your draft plan in your GitHub repository
- Final Verification Plan:  Submit your Final Verification plan to the appropriate dropbox on D2L.  Include a .pdf of the final verification plan in your GitHub repository
- Verification Report:  Submit your verification report to the appropriate dropbox on D2L.  Include a .pdf of the verification report in your GitHub repository.  The Verification Report should be based on your Final Verification plan and include a description of your verification environment(s) (both Simulation and Emulation) and results of all of your testing.  Also include sections on challenges encountered, next steps if you were to continue with the project, and a list of the contributions of each of the team members.  This Verification Report replaces what is typically a Design Report or Theory of Operations for my other project-based courses.
- Demo presentation slides - Include  a .pdf of your final project presentation in your GitHub repository.
- Source code, etc.: Include all of the source code you wrote for the project.  This code should naturally be in your GitHub repositiory since you are committing your changes, merging your source code, etc.
- Final GitHub repository - to GitHub...obviously, but I'd also like you to upload a .zip file of your repository to your Final Project Deliverables dropbox on D2L.  Some of you will  not be able to do so because D2L places a size limit on uploads.  Still,  I'd appreciate it if you could give it a try.  It's not a big deal either way, but it just might make our grading more efficient.

### Grading Rubric
This project is worth 100 points.  There is the possibility of extra credit projects and project presentations that stand out (in a good way)

- 30 pts: Draft and Final Verification plans
- 30 pts: Final project presentation
- 20 pts: Verification Report
- 20 pts: Quality of the code you wrote.  Code should be well organized and commented with meaningful signal names, variables, etc.
- up to 5 pts: Extra Credit.  Extra credit is just that - extra.  Your documentation and presentation must be prepared, well-written, and well presented for the project to be eligibile for extra credit
