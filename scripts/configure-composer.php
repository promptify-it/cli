<?php

$composerFile = 'composer.json'; // Path to composer.json
$localPackageUrl = '../../packages/core'; // Local path to check
$githubRepoUrl = 'https://github.com/promptify-it/core'; // GitHub repository URL

// Read the composer.json file
$composerJson = json_decode(file_get_contents($composerFile), true);

// Define the local path configuration to search for
$localPathConfig = [
    'type' => 'path',
    'url' => $localPackageUrl,
    'options' => [
        'symlink' => true,
    ],
];

// Define the GitHub repository configuration
$githubRepoConfig = [
    'type' => 'vcs',
    'url' => $githubRepoUrl,
];

// Iterate through the repositories to find and replace the local path
foreach ($composerJson['repositories'] as $key => $repository) {
    // If the local path configuration is found, replace it with the GitHub repo
    if (isset($repository['type'], $repository['url'])
        && $repository['type'] === 'path'
        && $repository['url'] === $localPackageUrl) {
        $composerJson['repositories'][$key] = $githubRepoConfig;
    }
}

// Write the updated composer.json back to file
file_put_contents($composerFile, json_encode($composerJson, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));

echo "Local path repository replaced with GitHub repository.\n";
