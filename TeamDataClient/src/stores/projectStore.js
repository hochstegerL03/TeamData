import { defineStore } from 'pinia';
import axios from 'axios';

export const useProjectStore = defineStore('projectStore', {
  state: () => {
    return {
      projects: [],
    };
  },
  getters: {
    isAuthenticated: (state) => state.user.id != '',
  },
  actions: {
    saveUserData(id, name) {
      this.user.id = id;
      this.user.name = name;
    },
    async getProjects() {
      const { data } = await axios.get('http://localhost:3000/projects');
      this.projects = data;
    },
  },
});
