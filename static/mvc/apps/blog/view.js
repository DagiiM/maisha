import View from '../../vitals/views/view.js';

class BlogView extends View{
    constructor(eventsystem){
        super(eventsystem);
        this.container = document.querySelector('.eleso-container-noshadow');

        this.endpoints = {
            ...this.endpoints,
            blogs : {
                url : 'api/blogs/',
                method : 'fetch',
                containerMethod : this.blogs.bind(this),
            }
            
          };
    }

    blogs(data) {
        let latest_blog = data.results[0];

        const h1  = document.createElement('h1');
        h1.textContent = latest_blog.title;
        this.container.appendChild(h1);
        const p = document.createElement('p');
        p.innerHTML = latest_blog.content;
        this.container.appendChild(p);
    }
}

export default BlogView;