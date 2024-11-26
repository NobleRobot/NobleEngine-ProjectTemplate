# Noble Engine: project template
The official project template for [Noble Engine](https://github.com/NobleRobot/NobleEngine) projects.

It contains the basic folder structure of a Noble Engine project and some boilerplate/example code to get you started, while the engine code itself is included as a [submodule](https://github.blog/2016-02-01-working-with-submodules/) so you can manage/update it separately from your project code (<u>details/instructions on that below</u>).

There are a few ways to start up a Noble Engine project. The recommended option for each step below is labeled.

* [Where will your project's remote copy be hosted?](#where)
  * [As a git repository on GitHub [*recommended*]](#where-github)
  * [Elsewhere (or nowhere)](#where-elsewhere)
* [How do you want to get the files on your local machine?](#how)
  * [By cloning the repository [*recommended*]](#how-clone)
    * [Via <u>Fork</u> [*recommended*]](#how-clone-fork)
    * [Via <u>GitHub Desktop</u>](#how-clone-githubdesktop)
    * [Via <u>Visual Studio Code</u>](#how-clone-vscode)
    * [Via <u>git command line</u>](#how-clone-cli)
  * [By downloading the files manually](#how-manual)
* [What next?](#next)

<a name=where></a>
## Where will your project's remote copy be hosted?

<a name=where-github></a>
### As a git repository on GitHub [*recommended*]

This repository is a [GitHub Template](https://github.blog/2019-06-06-generate-new-repositories-with-repository-templates/), which means you can quickly create a copy (not a fork) of it in your GitHub account, as if you'd downloaded it and then reuploaded it. It's a real time-saver!

- In the upper-right corner of this page, click the "`Use this template`" dropdown button and select "`Create a new repository`."
- Fill out the details of your project on the "Create a new repository" page. Remember to select the "Private" visibility option if you don't want your project code to be viewable to others.

<a name=where-elsewhere></a>
### Elsewhere (or nowhere)

If you want to host the remote copy of your project on another service (BitBucket, GitLab, your own server), mange a local git repository with no remote copy, or want to use a different (or no) version control system, rather than make a copy of this template, you'll clone or download this repository directly in the next step. 

*NOTE: Later steps for these workflows are outside the scope of this document.*

<a name=how></a>
## How do you want to get the files on your local machine?

<a name=how-clone></a>
### By cloning the repository [*recommended*]

***NOTE:** If you've created a new repository on GitHub in the previous step, replace <u>any</u> reference to `https://github.com/NobleRobot/NobleEngine-ProjectTemplate` in this step with the URL of your new repository.*

Because the project template repository contains a reference to the Noble Engine repository as a git submodule rather than tracking its code directly, it's possible to clone this repository and find that the `source/libraries/noble` folder (where the engine code lives) will be empty.

To avoid this, when you clone it you also need to "recurse submodules." This will also clone the Noble Engine repository and place it where the submodule reference in this repository lives: `source/libraries/noble`.

By default, git will not do this on its own, but some git clients will. A git client is an application that includes a copy of git and executes its commands for you inside of a graphical user interface. They all have the same capabilities because they all use git as their underlying tool, but they vary in UX features and how they visualize repositories.

Below are instructions for a few common git GUI clients, as well as the commands to do it directly via command line.

<a name=how-clone-fork></a>
#### Via <u>Fork</u> [*recommended*]

Fork (https://git-fork.com/) is an excellent GUI git client with a regrettably hard-to-Google name. It features an intuitive and powerful user interface, with good submodule support. Happily, **Fork will automatically recurse submodules** for you when you clone a remote repository.

- `File > Clone...`
- Enter the repository URL and other details and press "`Clone`."

<a name=how-clone-githubdesktop></a>
#### Via <u>GitHub Desktop</u>

GitHub Desktop (https://desktop.github.com/) is GitHub's open-source GUI-based git client. You can use it with remote git repositories that are not hosted on GitHub, but it has additional features that are useful when working with repositories in your GitHub account. Like Fork, **GitHub Desktop will also recurse submodules automatically** when you clone a remote repository.

There are two ways to clone a repository with GitHub Desktop:

- On your new repository's page (or this page):

  - Just below the header, find and click the "`<> Code`" button.
  - Select "Open with GitHub Desktop." The application (if installed) will open and paste in the information you need.

- In GitHub Desktop:

  - File > Clone repository...

  - Select the remote repository.
    - If you've created a new repository, and are logged in to GitHub in GitHub Desktop, you can find and select your repository from a list in the "GitHub.com" tab.
    - If you're cloning *this* repository, enter `https://github.com/NobleRobot/NobleEngine-ProjectTemplate` in the "URL" tab.

Press the "Clone" button.

<a name=how-clone-vscode></a>
#### Via <u>Visual Studio Code</u>

VSCode (https://code.visualstudio.com/), not to be confused with its big sibling Visual Studio, is the world's most popular code editor. It has a built-in git client that sits somewhere between a full GUI interface and a command line interface, and integrates well with GitHub.

- Open the Command Palette.
  - Windows/Linux: `Ctrl+Shift+P`
  - macOS: `Command+Shift+P`
- Type in "clone" and select `Git: Clone (Recursive)`. ***NOTE:** You must select the "(recursive)" option in order to recurse submodules.* A blank text box will appear.
  - Select the remote repository.
    - If you've created a new repository, and are logged in to GitHub in VSCode, select "Clone from GitHub" option. Type in the name of your new repository until it comes up in the list, then select it.
    - If you're cloning *this* repository, enter `https://github.com/NobleRobot/NobleEngine-ProjectTemplate` and press the Enter key.

***NOTE:** VSCode includes GUI buttons/menus you can use to clone a repository, but currently no way to select the "(recursive)" option, so stick to the Command Palette method.*

<a name=how-clone-cli></a>
#### Via <u>git command line</u>

Recent versions of git allow you to clone a remote repository *and* its submodules using one command, by adding the `--recurse-submodules` flag to the standard `clone` command:

```cmd
git clone --recurse-submodules https://github.com/NobleRobot/NobleEngine-ProjectTemplate "path/to/yourprojectfolder"
```

Very old versions (before v1.9) of git required you to jump though an extra hoop by cloning the submodule in a separate command:

```cmd
git clone https://github.com/NobleRobot/NobleEngine-ProjectTemplate "path/to/your project folder"
```

```cmd
cd "path/to/your project folder"
```

```cmd
git submodule update --init --recursive
```

This method also works with newer versions of git.

<a name=how-manual></a>
### By downloading the files manually

This option requires you to download the project and Noble Engine repositories separately, and then copy the engine into the a project subfolder:

- On your new repository's page (or this page), click the "`<> Code`" button and select "Download ZIP."
- Once downloaded, unzip the archive into your local project folder.

- Go to the page for the [Noble Engine repository](https://github.com/NobleRobot/NobleEngine) and select the "Download ZIP" for that repository.
- Unzip the Noble Engine ZIP archive into `path/to/your project folder/source/libraries/noble`.

<a name=next></a>
## What next?

Now that you've set up your new project, you can learn how to use Noble Engine by reviewing the information on the [Noble Engine repository page](https://github.com/NobleRobot/NobleEngine) and by consulting the [complete API reference documentation](https://noblerobot.github.io/NobleEngine/). You can also dive into the engine code directly to see how it works.

Have fun!
