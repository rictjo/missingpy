import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="missingforest",
    version="0.4.1",
    author       = "Richard Tjörnhammar",
    author_email = "richard.tjornhammar@gmail.com",
    description  = "Missing Data Imputation for Python : Package was forked from missingpy 0.2.0",
    long_description = long_description,
    long_description_content_type = "text/markdown",
    url = "https://github.com/rictjo/missingpy",
    packages=setuptools.find_packages(),
    classifiers=(
        "Programming Language :: Python :: 3.9",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Operating System :: OS Independent",
    ),
)
