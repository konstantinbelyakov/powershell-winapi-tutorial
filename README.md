# Windows API access from PowerShell

This repository contains tutorials and examples on how to access the Windows API from PowerShell scripts.

## How to Build the Web Site

You can build and run the website from this repository locally. If you have [Docker](https://www.docker.com/) installed, there's no need to install and configure mkdocs.

1. Clone this repository:

   ```cli
   git clone https://github.com/konstantinbelyakov/powershell-winapi-tutorial.git
   ```

2. Change the current working directory to the repository root:

   ```cli
   cd powershell-winapi-tutorial
   ```

3. Build the `ps_winapi_tutorial` Docker image from the [Containerfile](./Containerfile):

   ```cli
   docker build -t ps_winapi_tutorial -f Containerfile .
   ```

4. Build the content and start the development server within the container:

   ```cli
   docker run --rm -itp 8000:8000 -v "$(pwd):/d" ps_winapi_tutorial
   ```

5. Navigate to http://localhost:8000/ in your web browser.

You can edit markdown files from the `docs` folder and the website content will be rebuilt each time you save changes. When you are done, press `Ctrl`+`C` to stop the container with the development server. Next time  you can start from the third step, as the `ps_winapi_tutorial` is already build. However, you may need to rebuild the image if you have changes in the [Containerfile](./Containerfile) or [requirements.txt](./requirements.txt) files.
