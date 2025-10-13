# Project - [Legacy of the Occult]

This repository is for the semester project. For each milestone, you should update the corresponding
section with information about your project status. 

## Milestone 1

Update this section to describe your project for milestone 1 and complete the following sections. If your project is
using assets, be sure to keep the citations, sources, and resources section updated.

### Current Progress

For Milestone 1, I have setup a basic grid system for an isometric game. Additionally, I have 8-directional movement controls
for the main player character along with a camera that follows the player's movements. I have accomodated for WASD and arrow
keys.

### Challenges

One major challenge was realizing that the coordinate system for Godot is not the same as a normal coordinate system typically
found in most math classes. Rather than the positive y-axis pointing up, the positive y-axis points down, which had a major affect
on the implementation of my movement controls.

### Future Directions

Currently, I have plans to implement a building system. Each building will take a certain amount of resources and have different
roles and benefits. I also want to add the ability to recruit other characters to help with the creation of your village.

### Instructions

I have included a web build for Milestone 1 so people can test out the movement controls. In future milestones, I'm planning one
hosting this on GitHub pages, but for now this feature can be run locally on your computer.

```bash
#Clone the web branch of repository
git clone -b web https://gitlab.com/GHC-Students-Group/csci_1302_fall25/shared/gkawi/Project_gkawi.gitlab

#Alternatively, clone the entire repository and then switch branches afterwards
git clone https://gitlab.com/GHC-Students-Group/csci_1302_fall25/shared/gkawi/Project_gkawi.gitlab
cd Project_gkawi
git checkout web

#Confirm npm or npx is installed
npm --version
npx --version

#Run this command in the folder that contains index.html
npx local-web-server --https --cors.embedder-policy "require-corp" --cors.opener-policy "same-origin" --directory "."
```

You may get a prompt for installation. Just hit "y", and then CTRL-Click on the localhost URL.

---

## Milestone 2

Update this section to describe your project for milestone 2 and complete the following sections. If your project is
using assets, be sure to keep the citations, sources, and resources section updated.

### Current Progress

Update this section to describe the current progress of your project.

### Challenges

Update this section to describe the challenges for your project at this stage.

### Future Directions

What are your plans for the final submission?

---

## Final Submission

### Overview

The overview should be at least a paragraph and describe what your project is about.

### Tutorial

The tutorial should at least be 2 paragraphs long and describe how to get started using the program. For example, if it
is a game then you might want to introduce how to start playing and what the basic controls are. If it is a web
application, you might want to indicate how to navigate the application and interact with different components.

### Installation Instructions

Write instructions here for running your program and any files required to do so as appropriate for your programming
language**. For Python projects, this typically means having a `requirements.txt file` that you create using
“pip freeze > requirements.txt”.

### Citation, Sources, and References

Licenses for all assets used are included under the license folder. 

```
CREATOR: All of the assets included in this package are original and handmade by Cille Rosenøorn Ablidhauge, published
by Penzilla Design.
```
