<script setup lang="ts">
import { Head } from '@inertiajs/vue3';

defineProps<{
    canLogin: boolean;
    canRegister: boolean;
    laravelVersion: string;
    phpVersion: string;
}>();
</script>

<template>
    <Head title="Welcome" />

    <div class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 text-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="text-center mb-16">
                <h1 class="text-6xl font-bold mb-4 bg-clip-text text-transparent bg-gradient-to-r from-blue-400 to-purple-600">
                    Welcome to Apply
                </h1>
                <p class="text-xl text-gray-300">
                    A modern Laravel {{ laravelVersion }} application with Inertia 2, Vue 3, and TypeScript
                </p>
            </div>

            <div class="grid md:grid-cols-3 gap-8 mb-16">
                <div class="bg-gray-800 rounded-lg p-6 border border-gray-700 hover:border-blue-500 transition-colors">
                    <div class="text-blue-400 text-4xl mb-4">⚡</div>
                    <h3 class="text-xl font-semibold mb-2">Laravel 11</h3>
                    <p class="text-gray-400">
                        Built on the latest Laravel framework with modern PHP {{ phpVersion }}
                    </p>
                </div>

                <div class="bg-gray-800 rounded-lg p-6 border border-gray-700 hover:border-purple-500 transition-colors">
                    <div class="text-purple-400 text-4xl mb-4">🚀</div>
                    <h3 class="text-xl font-semibold mb-2">Inertia.js 2</h3>
                    <p class="text-gray-400">
                        Single-page app experience without the complexity of building an API
                    </p>
                </div>

                <div class="bg-gray-800 rounded-lg p-6 border border-gray-700 hover:border-green-500 transition-colors">
                    <div class="text-green-400 text-4xl mb-4">💚</div>
                    <h3 class="text-xl font-semibold mb-2">Vue 3 + TypeScript</h3>
                    <p class="text-gray-400">
                        Type-safe, reactive frontend with the Composition API
                    </p>
                </div>
            </div>

            <div class="grid md:grid-cols-2 gap-8 mb-16">
                <div class="bg-gray-800 rounded-lg p-6 border border-gray-700">
                    <h3 class="text-xl font-semibold mb-4">⚙️ Development Tools</h3>
                    <ul class="space-y-2 text-gray-400">
                        <li class="flex items-center">
                            <span class="text-green-400 mr-2">✓</span>
                            Vite for lightning-fast builds
                        </li>
                        <li class="flex items-center">
                            <span class="text-green-400 mr-2">✓</span>
                            Tailwind CSS for styling
                        </li>
                        <li class="flex items-center">
                            <span class="text-green-400 mr-2">✓</span>
                            TypeScript for type safety
                        </li>
                        <li class="flex items-center">
                            <span class="text-green-400 mr-2">✓</span>
                            Hot Module Replacement (HMR)
                        </li>
                    </ul>
                </div>

                <div class="bg-gray-800 rounded-lg p-6 border border-gray-700">
                    <h3 class="text-xl font-semibold mb-4">🐳 DevContainer Ready</h3>
                    <ul class="space-y-2 text-gray-400">
                        <li class="flex items-center">
                            <span class="text-green-400 mr-2">✓</span>
                            GitHub Codespaces compatible
                        </li>
                        <li class="flex items-center">
                            <span class="text-green-400 mr-2">✓</span>
                            VS Code Remote Containers
                        </li>
                        <li class="flex items-center">
                            <span class="text-green-400 mr-2">✓</span>
                            Pre-configured development environment
                        </li>
                        <li class="flex items-center">
                            <span class="text-green-400 mr-2">✓</span>
                            PHP, Node.js, and database included
                        </li>
                    </ul>
                </div>
            </div>

            <div class="text-center">
                <div class="inline-flex items-center gap-4 bg-gray-800 rounded-lg p-4 border border-gray-700">
                    <span class="text-gray-400">Version Info:</span>
                    <div class="flex gap-4">
                        <span class="px-3 py-1 bg-red-900/30 border border-red-700 rounded text-red-400">
                            Laravel {{ laravelVersion }}
                        </span>
                        <span class="px-3 py-1 bg-blue-900/30 border border-blue-700 rounded text-blue-400">
                            PHP {{ phpVersion }}
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
