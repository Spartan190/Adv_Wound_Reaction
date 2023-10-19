let docs_readmes = ["README.md"];
for readme in docs_readmes {
    HEMTT_VFS.join("docs").join(readme).copy(HEMTT_VFS.join(readme));
}