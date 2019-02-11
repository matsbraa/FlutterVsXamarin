using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Net.Http;
using System.Threading.Tasks;
using Xamarin.Forms;
using Newtonsoft.Json;

namespace XamarinXFlutter
{
    public partial class Posts : ContentPage
    {
        public Posts()
        {
            InitializeComponent();

            GetPosts();
        }

        public async Task GetPosts() {

            var client = new HttpClient();
            var content = await client.GetStringAsync("https://jsonplaceholder.typicode.com/posts/");
            
            PostsView.ItemsSource = JsonConvert.DeserializeObject<ObservableCollection<Post>>(content);
        }

        void Handle_ItemTapped(object sender, ItemTappedEventArgs e)
        {
            var postTapped = (Post)e.Item;
            Navigation.PushAsync(new PostDetail(postTapped.Id));
        }
    }
}
