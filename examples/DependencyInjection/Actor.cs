using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Proto;

namespace DependencyInjection
{
    public class DIActor : IActor
    {
        public class Ping
        {
            public Ping(string name)
            {
                Name = name;
            }

            public string Name { get; }
        }

        public readonly ILogger logger;

        public DIActor(ILogger<DIActor> logger)
        {
            this.logger = logger;
            logger.LogWarning("Created DIActor");
        }

        public Task ReceiveAsync(IContext context)
        {
            switch (context.Message)
            {
                case Ping p:
                {
                    logger.LogInformation($"Ping! {p.Name}");
                    break;
                }
            }
            return Task.CompletedTask;
        }
    }
}