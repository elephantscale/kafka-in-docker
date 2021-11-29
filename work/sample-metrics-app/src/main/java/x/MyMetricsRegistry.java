package x;

import java.net.InetSocketAddress;
import java.util.concurrent.TimeUnit;

import org.dhatim.dropwizard.prometheus.PrometheusReporter;
import org.dhatim.dropwizard.prometheus.Pushgateway;

import com.codahale.metrics.ConsoleReporter;
import com.codahale.metrics.MetricFilter;
import com.codahale.metrics.MetricRegistry;

public class MyMetricsRegistry {

	public final static String APP_ID = "my-metrics";

	public final static String PROMETHEUS_PUSH_GATEWAY_HOST = "localhost";
	public final static int PROMETHEUS_PUSH_GATEWAY_PORT = 9091;
	public final static int REPORTING_INTERVAL = 10; // 10 secs

	static final public MetricRegistry metricsRegistry;

	static {
		metricsRegistry = new MetricRegistry();
		registerConsoleReporter();
		registerPrometheusReporter();
	}

	static void registerConsoleReporter() {
		ConsoleReporter reporter = ConsoleReporter.forRegistry(metricsRegistry).convertRatesTo(TimeUnit.SECONDS)
				.convertDurationsTo(TimeUnit.MILLISECONDS).build();
		reporter.start(30, TimeUnit.SECONDS);
	}

	private static void registerPrometheusReporter() {
		final Pushgateway pushgateway = new Pushgateway(
				PROMETHEUS_PUSH_GATEWAY_HOST + ":" + PROMETHEUS_PUSH_GATEWAY_PORT);
		final PrometheusReporter reporter = PrometheusReporter.forRegistry(metricsRegistry).prefixedWith("kafkaapp")
				.filter(MetricFilter.ALL).build(pushgateway);
		reporter.start(REPORTING_INTERVAL, TimeUnit.SECONDS);
	}

}
