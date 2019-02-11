using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Xamarin.Forms;

namespace XamarinXFlutter
{
    public partial class PostDetail : ContentPage
    {
        public int PostId { get; set; }

        public PostDetail(int id)
        {
            InitializeComponent();
            PostId = id;

            GetPost();
        }

        public async Task GetPost()
        {

            var client = new HttpClient();
            var content = await client.GetStringAsync($"https://jsonplaceholder.typicode.com/posts/{PostId}");

             lbl.Text = JsonConvert.DeserializeObject<Post>(content).Title;
        }
    }
}
